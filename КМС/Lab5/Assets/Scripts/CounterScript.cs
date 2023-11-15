using TMPro;
using UnityEngine;

namespace Assets.Scripts
{
  public class CounterScript : MonoBehaviour
  {
    public TextMeshProUGUI counterText;
    public GameObject player;
    private static int _counter = 0;

    void Start()
    {
      counterText.text = _counter.ToString();
    }

    void OnTriggerEnter(Collider other)
    {
      if (other.gameObject == player)
      {
        _counter++;
        counterText.text = _counter.ToString();
      }
    }
  }
}