
# DamageMeter
Global DamageMeter for Armor Break Functionality.

![DamageMeterGIF](https://github.com/a4happy20/DamageMeter/assets/84645516/2d30b4f0-7dce-40f0-8c04-48fbef527724)
---

## Prerequisites
				

- You must have a working damage detection setup in your INI file.
- You can use Silent's script or use the Example.ini as a reference.
  
  
- You need to normalize your damage value to be between 0 and 1.
- If you want accumulative damage to be 400% of total hp for the final stage. You would divide "$damage" by "4.0".
- Updated Example.ini to demonstrate setting this with a key press
				      
~~~
$damageCalc = $damage/4.0
~~~
***
				    
## How to Use
				   
- Check the Example.ini
- $swapvar is the outfit
- $anim_default is for the outfit break stages

So if you only have one outfit. That should be $swapvar = 0.
Then $anim_Default will be the stages of outfit $swapvar 0.

  
## Optional Regen Effect
<details>
  <summary>Instructions:</summary>
  <p>&nbsp;</p>

  ---

  <img src="https://github.com/a4happy20/DamageMeter/assets/84645516/b41c4499-f91d-4bcf-82d9-ecb1e1f63c19" alt="DamageMeter_Regen">

  ---
   - Add these lines to your characters INI.
   - You can change effect type with "alt+H"
   - You can set fps with "alt+U" (speed up/slow down the regen effect)
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
      $damageCalc = 0

      if $triggeredDefault != 0
          $\global\regenEffect\regenEffect = 1
      endif

      $triggeredDefault = 0
      $anim_Default = 0
      $triggerStage_counter = 0
  endif

  ;Full Clothing on Statue's Blessing Menu
  if $\global\regenEffect\statueBlessing == 1
      $damageCalc = 0
      $triggeredDefault = 0
      $anim_Default = 0
      $triggerStage_counter = 0
  endif
  ~~~
  ---
</details>
