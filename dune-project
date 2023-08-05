(lang dune 3.9)

(name bioschecker)

(generate_opam_files true)

(source
 (github josecastillolema/bioschecker))

(authors "Jose Castillo Lema")

(maintainers "josecastillolema@gmail.com")

(license GPL-3.0)

(documentation
 https://https://github.com/josecastillolema/bioschecker)

(package
 (name bioschecker)
 (synopsis "BIOS settings checker")
 (description "BIOS settings checker for zero packet loss")
 (depends ocaml dune))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
