using UnityEngine;

namespace Assets
{
  public class ChangeCamera : MonoBehaviour
  {
    /*
     * We have two cameras. Display 1 and Display 2. We need to switch between them when key Q is clicked.
     */
    
    public Camera camera1;
    public Camera camera2;
    
    private void Start()
    {
      camera1.enabled = true;
      camera2.enabled = false;
    }
    
    private void Update()
    {
      if (!Input.GetKeyDown(KeyCode.Q)) return;
      
       camera1.enabled = !camera1.enabled;
       camera2.enabled = !camera2.enabled;

       Camera.SetupCurrent(camera1.enabled ? camera1 : camera2);
    }
  }
}