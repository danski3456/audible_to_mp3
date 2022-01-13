# Set up

1. Install audible-cli from pypi
2. Run audible quickstart to set up your profile
3. Run `./get_audiobook.sh` to download a specific file and convert it to MP3.

## Troubleshooting

The script to convert from Audible to MP3 requires ffmpeg >= 4.4. 

In a Raspberry Pi 4, this required to manuall compilation of ffmpeg with the following flags: ``./configure --arch=arm --extra-ldflags="-latoimc" --enable-libmp3lame` and installing `libmp3lame-dev`.
