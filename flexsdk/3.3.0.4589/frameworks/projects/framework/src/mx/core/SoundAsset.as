////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2006-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.core
{

import flash.media.Sound;

/**
 *  SoundAsset is a subclass of the flash.media.Sound class
 *  which represents sounds that you embed in a Flex application.
 *
 *  <p>The sound that you're embedding can be in an MP3 file.
 *  You can also embed a sound symbol that is in a SWF file produced by Flash.
 *  In both cases, the MXML compiler autogenerates a class that extends
 *  SoundAsset to represent the embedded sound data.</p>
 *
 *  <p>You don't generally have to use the SoundAsset class directly
 *  when you write a Flex application.
 *  For example, you can embed an MP3 file and use it in a SoundEffect
 *  simply by writing the following:</p>
 *
 *  <pre>
 *  &lt;mx:SoundEffect id="beep" source="&#64;Embed(source='Beep.mp3')"/&gt;</pre>
 *
 *  <p>without having to understand that the MXML compiler has created
 *  a subclass of SoundAsset for you.</p>
 *
 *  <p>However, it may be useful to understand what is happening
 *  at the ActionScript level.
 *  To embed a bitmap in ActionScript, you declare a variable
 *  of type Class, and put <code>[Embed]</code> metadata on it.
 *  For example, you embed an MP3 file like this:</p>
 *
 *  <pre>
 *  [Bindable]
 *  [Embed(source="Beep.mp3")]
 *  private var beepClass:Class;</pre>
 *
 *  <p>The MXML compiler sees the .mp3 extension, transcodes the MP3 data
 *  into the sound format that the player uses, autogenerates
 *  a subclass of the SoundAsset class, and sets your variable
 *  to be a reference to this autogenerated class.
 *  You can then use this class reference to create instances of the
 *  SoundAsset using the <code>new</code> operator, and you can use
 *  APIs of the Sound class on them:</p>
 *
 *  <pre>
 *    var beepSound:SoundAsset = SoundAsset(new beepClass());
 *    beepSound.play();</pre>
 *
 *  <p>However, you rarely need to create SoundAsset instances yourself
 *  because sound-related properties and styles can simply be set to a
 *  sound-producing class, and components will create sound instances
 *  as necessary.
 *  For example, to play this sound with a SoundEffect, you can 
 *  set the SoundEffect's <code>source</code> property to
 *  <code>beepClass</code>.
 *  In MXML you could do this as follows:</p>
 *
 *  <pre>
 *  &lt;mx:SoundEffect id="beepEffect" source="{beepClass}"/&gt;</pre>
 */
public class SoundAsset extends Sound implements IFlexAsset
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function SoundAsset()
    {
        super();
    }
}

}
