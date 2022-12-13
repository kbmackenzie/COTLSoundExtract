A guide on how to extract sound effects from Cult of the Lamb's FMOD soundbanks, with a script to automate the process!

**Disclaimer:** All of the content in COTL's FMOD soundbanks is copyrighted. I do not endorse using these sounds for **anything** that doesn't fall under **fair use**.

Cult of the Lamb uses FMOD for all of its music and sound effects. FMOD .fsb/.bank files are normally encrypted, but there are a few tools dedicated to to extracting sounds from them.

I've tried a lot of the popular tools though, from *python-fsb5* to *fsbext*, and none of them seem to work with Cult of the Lamb's FMOD files. They seem to work fine for other games, so I can only assume this must be a particularity of COTL's .bank files themselves.

Fortunately, [VGMStream](https://github.com/vgmstream/vgmstream) seems to work fine with COTL'S FMOD soundbanks! FMOD .bank files are a little quirky: Each bank file can contain any number of subsongs inside of it. VGMstream does a wonderful job of extracting each subsong separately, though sadly the task is extremely repetitive to do with VGMStream's CLI decoder, as you have to specify the index of a subsong in order to extract it individually (otherwise only the first subsong is extracted).

Because of this, I wrote a little Batch script that does all the work for you, extracting all the SFX from Cult of the Lamb's FMOD soundbanks separately as .wav files! Guidance on how to use the script (and a FAQ) are going to be below this.

Another alternative you have is to use [VGMstream's Foobar2000 component](https://github.com/vgmstream/vgmstream/blob/master/doc/USAGE.md#foo_input_vgmstream-foobar2000-plugin). You will have to download [Foobar2000](https://www.foobar2000.org/) and follow the instructions on how to install the VGMSstream component for it, however. Though it isn't too hard!

## The Script
You can quickly extract all the sounds at once with the LambExtract.bat script, provided you're on Windows and you have Cult of the Lamb installed through Steam (though a non-Steam workaround is provided in the [FAQ](#FAQ)).

All you have to do to use the script is:

1. Download the release package.
2. Extract "COTLSoundExtract.zip" to its own folder.
3. Run the LambExtract.bat script. Double-clicking on it should be enough.

And that's about it. All of the .wav files will be exported to a folder called "output" in the same directory as the script.

A few important notes about the script:
1. My script **intentionally skips over music files**. This is done out of respect to the developers, as the game's music is currently purchasable on Steam.
2. This script looks for the **Steam** installation path for Cult of the Lamb. If you don't have the game installed through Steam, this script will not find the music files. See the [FAQ](#FAQ) for guidance on how to set your own path.

If you find any issues with the script, please read the [FAQ](#FAQ) section.

## FAQ

**Q:** *"The script can't find the .bank files!"* / *"Cult of the Lamb is installed in a different path on my computer!"*

**A:** You *can* manually change the path the script uses. To do so, all you have to do is open the script in any text editor (such as Notepad) and change the contents of line 12 from this:
```batch
call :ExtractMusic "%fullPath%" "%thisPath%"
```
To this:
```batch
call :ExtractMusic "InsertYourPathHere" "%thisPath%"
```
Where in place of *InsertYourPathHere* you should put the full path to the `Cult of the Lamb\Cult Of The Lamb_Data\StreamingAssets` folder, wherever that is on your computer.

Remember: Your path should be between the quotation marks!


**Q:** *"I got an error that says the VGMStream folder couldn't be found!"*

**A:** Please be sure you downloaded the proper package. The **COTLSoundExtract.zip** file should contain not only the LambExtract.bat script but also the `vgmstream-win` folder, which the script needs.

Also: **Do not** move the LambExtract.bat script to another folder without moving the `vgmstream-win` folder alongside it. Again, the script needs that. 

If you really want to have the script in a folder, just make a shortcut for it. (Though I don't see why you would.)