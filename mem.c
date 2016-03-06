/*****************************************************
 * Copyright Grégory Mounié 2008-2013                *
 * This code is distributed under the GLPv3 licence. *
 * Ce code est distribué sous la licence GPLv3+.     *
 *****************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "mem.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define BUDDY_ADDR(addr, i)                         \
    ((((uint64_t)(addr) - (uint64_t)(zone_memoire)) \
	^ (1 << (i))) + (uint64_t)zone_memoire)

void *zone_memoire = 0;
bool mem_initialized = false;

uint64_t *TZL[BUDDY_MAX_INDEX + 1] = {NULL};

/* Helpers */
static int indexFromSize(unsigned long size);
static void addTZL(uint64_t *ptr, int i);
static bool findAndDelete(uint64_t *ptr, uint16_t ordre);
static int divide(uint16_t order);

/** squelette du TP allocateur memoire */
int mem_init()
{
    if (! zone_memoire)
        zone_memoire = (void *) malloc(ALLOC_MEM_SIZE);
    if (zone_memoire == 0) {
        perror("mem_init:");
        return -1;
    }

    TZL[BUDDY_MAX_INDEX] = (uint64_t *)zone_memoire;
    *TZL[BUDDY_MAX_INDEX] = 0;

    mem_initialized = true;

    return 0;
}


void *mem_alloc(unsigned long size)
{
    /* Check that mem has been initialized */
    if (!mem_initialized) {
        perror("error: Memory has not been initialized!");
        return (void*)0;
    }

    /* Check that size > 0 */
    if (size > ALLOC_MEM_SIZE || size == 0) {
        perror("error: Allocation of size forbidden!");
        return (void*)0;
    }
    /* Check that the size is sup than addr size */
    if (size < sizeof(uint64_t*))
        size = sizeof(uint64_t*);


    /* Start allocation */
    int i = indexFromSize(size);
    if (!TZL[i]) {
        if (divide(i+1))
            return (void *)0;
    }

    uint64_t *retAddr = TZL[i];
    findAndDelete (retAddr, i);

    return (void *)retAddr;
}


int mem_free(void *ptr, unsigned long size)
{
    if ((uint64_t)ptr < (uint64_t)zone_memoire
        ||  (uint64_t)ptr >= (uint64_t)zone_memoire + ALLOC_MEM_SIZE) {
        perror("error: Cannot free memory (out of boundaries)");
        return -1;
    }

    /* Set size to min if < min */
    if (size < sizeof(uint64_t*))
        size = sizeof(uint64_t*);

    /* Start free */
    int i = indexFromSize(size);

    /* Define buddy */
    uint64_t buddy = BUDDY_ADDR(ptr, i);

    while (findAndDelete((uint64_t *)buddy, i) && i <= BUDDY_MAX_INDEX) {
        i++;
        ptr = (uint64_t *)MIN((uint64_t)ptr, (uint64_t)buddy);
        buddy = BUDDY_ADDR(ptr, i);
    }

    addTZL(ptr, i);

    return 0;
}


int mem_destroy()
{
    mem_initialized = false;

    free(zone_memoire);
    zone_memoire = 0;

    return 0;
}
/** Fin du squelette du TP allocateur memoire */


/* User functions */
static int indexFromSize(unsigned long size)
{
    int i = BUDDY_MAX_INDEX;
    while (((size - 1) >> i) == 0 && i >= 0)
        --i;

    return i+1;
}

static void addTZL(uint64_t *ptr, int i)
{
    if (TZL[i] == NULL) { 
        TZL[i] = ptr;
        findAndDelete(ptr, i + 1);
        *TZL[i] = (uint64_t)NULL;
    } else {
        uint64_t *temp = TZL[i];
        TZL[i] = ptr;
        findAndDelete(ptr, i + 1);
        *TZL[i] = (uint64_t)temp;
    }
}

static bool findAndDelete(uint64_t *ptr, uint16_t ordre)
{
    /* Exit */
    if (ordre > BUDDY_MAX_INDEX)
        return false;
    else if (TZL[ordre] == NULL)
        return false;

    
    uint64_t *suiv, *cour = TZL[ordre];

    if (cour == ptr) {
        TZL[ordre] = (uint64_t *)(*ptr);
        return true;
    } else {
        while ((*cour) != 0) {
            suiv = (uint64_t *)(*cour);

            if (suiv == ptr) {
                *cour = *suiv;
                return true;
            }
            cour = suiv;
        }
    }

    return false;
}

static int divide(uint16_t order)
{
    if (order > BUDDY_MAX_INDEX) {
        perror("error: Not enough space!");
        return -1;
    }

    /* Divide until a block is found */
    if (TZL[order] == NULL)
        if (divide(order + 1))
            return -1;

    /* Define buddy */
    uint64_t *buddy = (uint64_t *)BUDDY_ADDR(TZL[order], order-1);

    /* Add new blocs into TZL */
    addTZL(TZL[order], order - 1);
    addTZL(buddy, order - 1);

    return 0;
}
