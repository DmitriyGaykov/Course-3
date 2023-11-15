using System;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Assets.Scripts
{
  public class MenuScript : MonoBehaviour
  
  //SampleScene инлекс 2
  {
    public void OnScene1()
    {
      SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }
    
    //Cubes 1
    public void OnScene2()
    {
      SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 2);
    }
  }
}