#!/usr/bin/env nextflow

params.greeting = 'Hello world!' 
greeting_ch = Channel.of(params.greeting) 

process SPLITLETTERS { 
    input: 
    val x 

    output: 
    path 'chunk_*' 

    script: 
    """
    printf '$x' | split -b 6 - chunk_
    """
} 

process CONVERTTOUPPER { 
    input: 
    path y 

    output: 
    stdout 

    script: 
    """
    rev $y
    """
} 
// this process converts strings to upper

workflow { 
    letters_ch = SPLITLETTERS(greeting_ch) 
    results_ch = CONVERTTOUPPER(letters_ch.flatten()) 
    results_ch.view { it } 
}