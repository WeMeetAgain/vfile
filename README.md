# vfile

Simple virtual file format based on [vinyl](https://github.com/gulpjs/vinyl).

A vfile, or virtual file, provides a file-like interface for accessing the
contents of arbitrary data as a stream of element type `(unsigned byte 8)`.

The major attributes of a vfile are:
 - its path metadata
 - its contents, the underlying data

To access the contents of a vfile, the vfile should be opened, and read from
the returned stream.

## License

MIT
