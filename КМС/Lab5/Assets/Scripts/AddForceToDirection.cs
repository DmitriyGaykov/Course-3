using UnityEngine;
using UnityEngine.EventSystems;

namespace Assets.Scripts
{
  public class AddForceToDirection : MonoBehaviour
  {
    // 8.	Напишите код, который по щелчку мыши толкает кубы
    // (т.е. придает импульс тем кубам, которых коснется курсор, в направлении от камеры)
    // (код см. в Лекции 3 в теме EventSystem). Для большей реалистичности сила воздействия
    // на кубы может быть пропорциональна расстоянию до объекта.
    
    public float force = 100f;
    public Camera camera;
    public EventSystem eventSystem;
    
    void Update()
    {
      if (!(Input.GetMouseButtonDown(0) && !eventSystem.IsPointerOverGameObject())) return;
      Ray ray = camera.ScreenPointToRay(Input.mousePosition);
      if (!Physics.Raycast(ray, out RaycastHit hit)) return;
      
      var direction = hit.transform.position - camera.transform.position;
      hit.transform.GetComponent<Rigidbody>()?.AddForce(direction * force);
    }
  }
}