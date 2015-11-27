#!/bin/bash
ffmpeg -pattern_type glob -i '*.JPG' -pix_fmt yuv420p output.mov