using UnityEngine;
using UnityEngine.AI;

namespace Assets
{
  public class ClickNavScript : MonoBehaviour
  {
    /*
 * 9.	На второй сцене с помощью метода Physics.Raycast определите координаты
 * точки в сцене, по щелчку мышью и назначьте агенту координаты этой точки,
 * т.е. агент должен двигаться в ту точку, которую указали щелчком мыши. Код к этому
 * заданию можно найти в лекции или в статье по ссылке https://habr.com/ru/post/646039/). Должен быть виден лучь, который выходит из камеры.
 */
    public NavMeshAgent agent;

    private void Update()
    {
      if (Input.GetMouseButtonDown(0))
      {
        var ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out var hit))
        {
          agent.SetDestination(hit.point);
        }
      }
    }
  }
}