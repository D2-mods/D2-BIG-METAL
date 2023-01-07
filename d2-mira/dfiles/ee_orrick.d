//for Pulse Ammunition
//Add to Orrick's dialogues


EXTEND_BOTTOM ~DORRICK~ 0 2 18 19 38

IF ~ PartyHasItem("%prototype%")            // has prototype
     PartyHasItem("%bigmetalrod%")          // has Big Metal Rod
     GlobalLT("Chapter","GLOBAL",3)         // pre-Chapter 3
     Global("d2OswaldBigMetal","GLOBAL",2)  // Oswald gave prototype
   ~ REPLY @10201 GOTO d2OrrickShowPrototype1

IF ~ PartyHasItem("%prototype%")            // has prototype
     PartyHasItem("%bigmetalrod%")          // has Big Metal Rod
     GlobalGT("Chapter","GLOBAL",2)         // Chapter 3 or later
     Global("d2OswaldBigMetal","GLOBAL",2)  // Oswald gave prototype
     Global("d2OrrickBigMetal","GLOBAL",0)  // not mentioned before
   ~ REPLY @10201 GOTO d2OrrickShowPrototype2

IF ~ PartyHasItem("%prototype%")            // has prototype
     PartyHasItem("%bigmetalrod%")          // has Big Metal Rod
     GlobalGT("Chapter","GLOBAL",2)         // Chapter 3 or later
     Global("d2OswaldBigMetal","GLOBAL",2)  // Oswald gave prototype
     Global("d2OrrickBigMetal","GLOBAL",1)  // has been mentioned before
   ~ REPLY @10202 GOTO d2OrrickShowPrototype3

END



APPEND ~DORRICK~

IF ~~ BEGIN d2OrrickShowPrototype1  // pre-Chapter 3
  SAY @10211  // Orrick says stuff
  IF ~~ DO ~ SetGlobal("d2OrrickBigMetal","GLOBAL",1)
           ~ EXIT
END

IF ~~ BEGIN d2OrrickShowPrototype2  // Chapter 3 or later (not mentioned before)
  SAY @10221  // Orrick says stuff
    = @10222  // Orrick makes offer
  IF ~ PartyGoldGT(4999)  // if 5000 gold
     ~ REPLY @10241 DO ~ SetGlobal("d2OrrickBigMetal","GLOBAL",2)  // accept offer
                       ~ GOTO OrrickPulse
  IF ~
     ~ REPLY @10242 DO ~ SetGlobal("d2OrrickBigMetal","GLOBAL",1)  // reject offer
                       ~ EXIT
END

IF ~~ BEGIN d2OrrickShowPrototype3  // Chapter 3 or later
  SAY @10231  // Orrick makes offer
  IF ~ PartyGoldGT(4999)  // if 5000 gold
     ~ REPLY @10241 DO ~ SetGlobal("d2OrrickBigMetal","GLOBAL",2)  // accept offer
                       ~ GOTO OrrickPulse
  IF ~
     ~ REPLY @10242 DO ~ SetGlobal("d2OrrickBigMetal","GLOBAL",1)  // reject offer
                       ~ EXIT
END

IF ~~ BEGIN OrrickPulse
  SAY @10251  // Orrick says stuff
  IF ~~ DO ~ TakePartyGold(5000)
             TakePartyItem("%prototype%")
             GiveItemCreate("%pulse%",LastTalkedToBy,0,0,0) 
           ~ EXIT
END

END