lazy_ncaa
=========

Run this script to generate a filled-out bracket, with probabilities based entirely on historical matchups between seeds.

**NOTE**: This script was written in early 2009. I haven't code-reviewed it since, so I make no claims about the (likely lack of) awesomeness of it.

Example
-------

    ~/dev/play/ncaa (master) $ ./ncaa.rb 
    
    BRACKET 1
    ( 1) Kansas    
    (16) Lehigh     ( 1) Kansas    
    ( 8) UNLV       ( 8) UNLV      
    ( 9) N. Iowa                    ( 1) Kansas    
    ( 5) Michigan S                 ( 5) Michigan S
    (12) New Mexico ( 5) Michigan S
    ( 4) Maryland   ( 4) Maryland  
    (13) Houston                                  ( 1) Kansas    
                                                               ( 1) Kansas    
    ( 3) Georgetown                               (10) Georgia Te
    (14) Ohio       ( 3) Georgetown
    ( 6) Tennessee  ( 6) Tennessee 
    (11) San Diego                  ( 3) Georgetown
    ( 7) Oklahoma S                 (10) Georgia Te
    (10) Georgia Te (10) Georgia Te
    ( 2) Ohio St.   ( 2) Ohio St.  
    (15) UC Santa B
    
    BRACKET 2
    ( 1) Syracuse  
    (16) Vermont    ( 1) Syracuse  
    ( 8) Gonzaga    ( 9) Florida St
    ( 9) Florida St                 ( 1) Syracuse  
    ( 5) Butler                     ( 5) Butler    
    (12) UTEP       ( 5) Butler    
    ( 4) Vanderbilt ( 4) Vanderbilt
    (13) Murray St.                               ( 1) Syracuse  
                                                               ( 1) Syracuse  
    ( 3) Pittsburgh                               ( 6) Xavier    
    (14) Oakland    ( 3) Pittsburgh
    ( 6) Xavier     ( 6) Xavier    
    (11) Minnesota                  ( 6) Xavier    
    ( 7) BYU                        (10) Florida   
    (10) Florida    (10) Florida   
    ( 2) Kansas St. ( 2) Kansas St.
    (15) North Texa
    
    BRACKET 3
    ( 1) Kentucky  
    (16) E Tenn. St ( 1) Kentucky  
    ( 8) Texas      ( 9) Wake Fores
    ( 9) Wake Fores                 ( 1) Kentucky  
    ( 5) Temple                     ( 4) Wisconsin 
    (12) Cornell    (12) Cornell   
    ( 4) Wisconsin  ( 4) Wisconsin 
    (13) Wofford                                  ( 1) Kentucky  
                                                               ( 2) West Virgi
    ( 3) New Mexico                               ( 2) West Virgi
    (14) Montana    ( 3) New Mexico
    ( 6) Marquette  ( 6) Marquette 
    (11) Washington                 ( 3) New Mexico
    ( 7) Clemson                    ( 2) West Virgi
    (10) Missouri   ( 7) Clemson   
    ( 2) West Virgi ( 2) West Virgi
    (15) Morgan St.
    
    BRACKET 4
    ( 1) Duke      
    (16) Ark-Pine B ( 1) Duke      
    ( 8) California ( 9) Louisville
    ( 9) Louisville                 ( 1) Duke      
    ( 5) Texas A&M                  ( 5) Texas A&M 
    (12) Utah St.   ( 5) Texas A&M 
    ( 4) Purdue     ( 4) Purdue    
    (13) Siena                                    ( 1) Duke      
                                                               ( 1) Duke      
    ( 3) Baylor                                   ( 2) Villanova 
    (14) Sam Housto (14) Sam Housto
    ( 6) Notre Dame ( 6) Notre Dame
    (11) Old Domini                 ( 6) Notre Dame
    ( 7) Richmond                   ( 2) Villanova 
    (10) St. Marys  ( 7) Richmond  
    ( 2) Villanova  ( 2) Villanova 
    (15) Robert Mor
    
    
    FINAL FOUR
    ( 1) Kansas    
    ( 1) Syracuse   ( 1) Kansas    
                                      ( 1) Kansas    
    ( 2) West Virgi ( 1) Duke      
    ( 1) Duke      
    
    Bad Tournaments: 0

That last line indicates how many times the script had to "give up" since it hadn't seen a particular match-up before. For example, a 2-seed and 14-seed have never met in the past, so the script just re-starts from scratch.

Disclaimer
----------

I'm not endorsing gambling. This program basically puts random numbers into buckets. Use at your own peril.

Copyright
---------

This work is licensed under the MIT license, which is found at MIT-LICENSE in this repository.
