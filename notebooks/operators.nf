#!/usr/bin/env nextflow

nextflow.enable.dsl=2

nums = Channel.of(1, 2, 3, 4) 
square = nums.map { it -> it * it } 
square.view()

Channel
    .of(1, 2, 3, 4)
    .map { it -> it * it }
    .view()