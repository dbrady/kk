# kk - Personal diary/journaling/logging tool

kk is an ultra-lightweight tool for journaling, logging and
diarykeeping. It stores the journal in a sqlite3 database, ensuring
fast updates and searches even when the logging gets fairly
involved. kk is inspired by the awesome
[jrnl app](http://maebert.github.io/jrnl/), and my intention is to
make kk "scratch my own itch" for specialty needs like templates,
reporting and logging.

If all you need is a command-line journal app with tagging and simple
searching, you probably want to use jrnl.

# Feature Comparison with jrnl

This is a list of the key features of kk and jrnl so that I can
implement them using this document as a sort of "README-driven
development" guide.

| Feature                                  | kk | jrnl |
|------------------------------------------+-----+------|
| Exists at all, in any way, shape or form | NO  | yes  |
| Add journal entry with title and date    | NO  | yes  |
| Show all journal entries                 | NO  | yes  |
| Add entries from the command line        | NO  | yes  |
| Export to json                           | NO  | yes  |
| Search by date or date range             | NO  | yes  |
| List tags                                | NO  | yes  |
| Add tags with @ from CLI                 | NO  | yes  |
| Search by tag                            | NO  | yes  |
| 256-bit AES Encryption                   | NO  | yes  |
| Portable by saving file to dropbox       | NO  | yes  |
| Init config, db on startup if no db      | NO  | yes  |
| Web server                               | NO  | NO   |
| CLI->browser capture for longer entries  | NO  | NO   |
| Template support                         | NO  | NO   |
| Extra document data                      | NO  | NO   |
| Search by document data                  | NO  | NO   |

# Template Support

I'm not sure yet how I want to tackle this, even to demonstrate how
I'd use it (a la "design by wishful thinking"), but in short I want to
create templates that let me quickly add new entries later. **These
examples will likely change!**

    kk --templates
    # -> list templates

    kk %fbg title: "Fasting Blood Glucose", body: %1, glucose:i: %1, fasting:b: true
    # -> Creates/updates template "fbg" so that it takes one value
    # from the command-line and writes it as the body of the journal
    # entry. It sets the title to "Fasting Blood Glucose", and then
    # adds extra data fields "glucose" (integer, set to .to_i of %1)
    # and "fasting" (bool, set to true). TOTALLY UNSURE if I even want
    # to support special types here or if everything should just be
    # strings. On one hand I could see it all going into a json blob
    # in the database anyway; on the other hand if create objects that
    # the database can understand I can sift and sort by those types
    # rather than by strings, so 10 would come after 9 instead of
    # between 1 and 2, etc.

    kk %fbg 86
    # -> Records a glucose entry of 86.

# Extra Document Data

An extension of the extra fields idea raised by the templating
thought. Ideally I want to all some kind of NoSQL-like data storage
and searching, like "Show me all the glucose logs that are fasting:
false" or "Show me the highest glucose entry in this date range". For
now I'm thinking of either a JSON blob field, or if I move to postgres
I can consider using an hstore column.

TODO: Give some serious thought to rolling the whole thing with PStore
or, even better, YAML::Store instead of sqlite. This would essentially
make the whole store a NoSQL-style database. It essentially returns a
giant hash so its use as a Key/Value store would be obvious. Expanding
it to a "proper" document database might require more tooling than
it's worth, dunno. Definitely have to store off my own indices, but I
might be able to aggregate the values into document objects if the
YAML store has a clean marshaling mechanism.

Do I want to go to the trouble of separating the data access from the
application? That means rolling a lot of the data access myself, sigh,
but would it be worth it to be able to switch from sqlite to
yaml/store?

(Another consideration is speed: I know sqlite3 is pretty fast, but
yaml store could end up implicitly creating objects for the entire
file every time I loaded it. The result would be a huge performance
hit once the journal got large. Food for thought. One option would be
to roll my own store somehow, but right now I think perhaps the best
option might be to use sqlite3 and roll as much of a key/value store
on top of it as I need, but only as I need it.)
