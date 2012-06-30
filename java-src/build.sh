#!/bin/sh
(cd eu/elevat && javac -implicit:none TwoIntParamJSignal.java)
jar cvf TwoIntParamJSignal.jar eu/elevat/TwoIntParamJSignal.class
