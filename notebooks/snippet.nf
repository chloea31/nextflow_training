#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process SAYHELLO {
    script:
    """
    echo 'Hello world!'
    """
}

process EXAMPLE {

    output:
        path "chunk_archive.gz"
    script:
    """
    echo 'Hello world!\nHola mundo!\nCiao mondo!\nHallo Welt!' > file
    cat file | head -n 1 | head -c 5 > chunk_1.txt
    gzip -c chunk_1.txt  > chunk_archive.gz
    """
}

workflow {
    EXAMPLE()
    | view()
}