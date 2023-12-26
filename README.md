
# DamageMeter
Global DamageMeter for Armor Break Functionality.

![DamageMeterGIF](https://github.com/a4happy20/DamageMeter/assets/84645516/2d30b4f0-7dce-40f0-8c04-48fbef527724)
---

## Prerequisites
				

- You must have a working damage detection setup in your INI file.
- You can use Silent's script or use the Example.ini as a reference.
  
  
- You need to normalize your damage value to be between 0 and 1.
- If your last stage is triggered at damage value 4.5 you would divide "$damage" by "4.5".
				      
~~~
$damageCalc = $damage/4.5
~~~
***
				    
## How to Use
				   
- Add these lines to your character ini.
- Set your damage thresholds.
- You don't have to use all of them.
- You can use 1-3, 1-5, or 1-7.
  - If you use 1-7 there will be an additional threshold automatically set to 1.0
  - If you use 1-5. $threshold5 must be 1.0
  - If you use 1-3. $threshold3 must be 1.0

---				
~~~
[Constants]
global $damageCalc = 0
global $damageMeterActive = 0
global $damageMeter_start = 0
global $threshold1 = 0.22222222
global $threshold2 = 0.33333333
global $threshold3 = 0.44444444
global $threshold4 = 0.55555555
global $threshold5 = 0.66666666
global $threshold6 = 0.77777777
global $threshold7 = 0.88888888

[Present]
if $active == 1
    run = CommandListDamageMeter
endif
~~~
---
			     
- Add this line to your character ini.
			   
~~~
[TextureOverride"Character"Position]
$\global\damageMeter\damageMeterActive = 1
~~~

			     
## Setting the Amount of Stages
  
- Set "fiveLevels" and "sevenLevels" to appropriate values.

			     
##### Three Stages:
---
~~~
$\global\damageMeter\fiveLevels = 0
$\global\damageMeter\sevenLevels = 0
~~~
                          
##### Five Stages:
---                           
~~~
$\global\damageMeter\fiveLevels = 1
$\global\damageMeter\sevenLevels = 0
~~~
                    
##### Eight Stages:
---                             
~~~
$\global\damageMeter\fiveLevels = 1
$\global\damageMeter\sevenLevels = 1
~~~
                                   

## Command:
                      
- Add this command to your "Commands" section in your character ini.
---      
~~~
[CommandListDamageMeter]
;IniParams
x95 = $damage
x87 = $threshold1
y87 = $threshold2
z87 = $threshold3
w87 = $threshold4
y88 = $threshold5
z88 = $threshold6
w88 = $threshold7

;If you have three stages set both to 0. If you have five stages set "...\sevenLevels = 0"
$\global\damageMeter\fiveLevels = 1
$\global\damageMeter\sevenLevels = 1

;If damaged activate the Meter.
if $\global\HealthBar\health < $health && $gotDamaged > 0
  if $damage > 0.0
    if $damage <= 1.0
      $\global\damageMeter\damageMeter_start = 1
      $damageMeter_start = 1
    endif
  endif

else
  $\global\damageMeter\damageMeter_start = 0
  $damageMeter_start = 0
endif

;If over this threshold stop the meter from fading.
if $damage >= 0.86666666
	$\global\damageMeter\delay = 0
	$\global\damageMeter\alpha = 1
endif
~~~
---
  
## Optional Regen Effect
<details>
  <summary>Instructions</summary>
  <p>&nbsp;</p>
  <img src="https://github.com/a4happy20/DamageMeter/assets/84645516/b41c4499-f91d-4bcf-82d9-ecb1e1f63c19" alt="DamageMeter_Regen">

  ---
   - Add these lines to your characters INI.
   - You can change effect type with "alt+H"
  ---	 
  ~~~
  [Present]
  if $active == 1
      run = CommandListRegen
  endif

  [TextureOverride"Character"Position]
  $\global\regenEffect\regenActive = 1

  [CommandListRegen]
  ; triggers at tubby and over 80% health.
  if $\global\regenEffect\tubby == 1 && $health >= 0.8
         $\global\regenEffect\regenEffect = 1
 	 ;Add lines to restore outfit
     endif
  endif

  ; triggers when you open the healing menu at a statue.
  if $\global\regenEffect\statueBlessing == 1
  ;Add lines to restore outfit
  endif
  ~~~
  ---
</details>
