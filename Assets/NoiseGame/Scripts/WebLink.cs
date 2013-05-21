/******************************************
  * uWebKit 
  * (c) 2012 8 bit buffalo
  * josh@uwebkit.com
*******************************************/

using UnityEngine;
using System.Collections;
//using UWK;
using System.Collections.Generic;

/// <summary>
/// Basic example of using a WebView on a 3D Unity surface
/// </summary>
 
// IMPORTANT: Please see the WebGUI.cs example for 2D support

public class WebLink : MonoBehaviour
{
	
	#region Inspector Fields
	
	public string URL = "http://www.google.com";
	public TextAsset HtmlText;
	
	#endregion
	
	public void OnMouseUp ()
	{
		//Application.OpenURL( URL );
	}
	
	// Use this for initialization
	void Start ()
	{	
		

		
	}
	
	

	
}
