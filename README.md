
# Articles

- https://haskell-lang.org/tutorial/string-types
- http://blog.ezyang.com/2010/08/strings-in-haskell/
- [reddit discussion of performance problem](https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/)
- https://mmhaskell.com/blog/2017/5/15/untangling-haskells-strings


# Packages

- String is in [base](http://hackage.haskell.org/package/base)
- [text](https://hackage.haskell.org/package/text)
- [utf8-string](http://hackage.haskell.org/package/utf8-string)
- [compact-string](http://hackage.haskell.org/package/compact-string)


# An "ideal" string type

There are (at least) 5 string types in Haskell but not the "ideal" one. It seems
it would be nice to have a string with an in-memory UTF-8 representation
(probably both strict and lazy versions). It seems [I'm not
alone](https://www.reddit.com/r/haskell/comments/4p2vx7/what_can_i_do_to_help_the_stringbytestringtext/d4i935z/).

Could be that [utf8-string](http://hackage.haskell.org/package/utf8-string) is
that string type. However, this one doesn't have fusion AFAIK. Also, there seems
to be the issue of whether to use a pinned ByteString or not (for better GC
properties).
