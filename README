# Email

It's a thing.

    $ email -h
    Options:
            --from, -f <s>:   Sender's email address
              --to, -t <s>:   Receiver's email address
         --subject, -s <s>:   Subject
            --body, -b <s>:   Body (default: (no body))
      --attachment, -a <s>:   Attachment file (multiple allowed)
        --username, -u <s>:   Username
        --password, -p <s>:   Password
            --host, -H <s>:   Host
            --port, -P <s>:   Port
            --auth, -A <s>:   Authentication type (default: plain)
             --via, -v <s>:   Connection method (default: smtp)
                --help, -h:   Show this message

## Configuration

Any of the above settings can be configured to be set automatically
by including them in a ~/.emailconfig file. For example, to configure
for use with a Gmail client, the contents of .emailconfig might look like:

    username = me@gmail.com
    password = mypassw0rd
    host = smtp.gmail.com
    port = 587

Now you can simply type

    $ email.rb -t mybuddy@gmail.com -s Noms -b "Let's eat lunch."

and the rest of the configuration will be filled in from .emailconfig.


## Examples

* Send reminders to myself

        $ alias emailme="email.rb -t me@gmail.com"
        $ emailme -s "pay rent"

* Send longer body from stdin by ending the command with `-`

        $ emailme -s "A haiku" -
        Email is a tool
        for sending email from the
        command line. Use it.
        ^D

* Send attachments

        $ emailme -s "Kitten pics" -a kitten1.png -a kitten2.png

