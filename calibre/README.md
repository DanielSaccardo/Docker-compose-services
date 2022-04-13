### How to construct calibre database

First of all install the calibre apt:

```
sudo apt install calibre -y
```

After that every time you add or remove a book run you need to recreate the database. You can do so by executing the following command:

```
sudo rm /path/to/your/calibrelib/metadata.db && sudo calibredb add --with-library=/path/to/your/calibrelib -r /path/to/your/calibrelib *
```

To automate this process you could create a crontab and set every when to update the metadata.db file.
To create the crontab execute:

```
sudo crontab -e
```

Then here follow the instruction that may be at the beginning.

If you rarely add a book you could create an alias for simplify the process and call it when you need.
For do this you need to edit the .bashrc:

```
sudo nano ~/.bashrc
```

Scroll to the end and add the following lines:

```
CALIBRE_LIB=/path/to/your/calibrelib/
alias rebuildCalibreDB="sudo rm $CALIBRE_LIB/metadata.db && sudo calibredb add --with-library=$CALIBRE_LIB -r $CALIBRE_LIB *"
```

⚠️ Pay attention to not touch anything else, it might corrupt the terminal and also the ssh.

After that save, exit and apply the changes with:

```
source ~/.bashrc
```
