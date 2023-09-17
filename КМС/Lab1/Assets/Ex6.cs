using System;
using UnityEngine;

namespace Assets
{
    public class Ex6 : MonoBehaviour
    {
        private Renderer _renderer = null;
        
        private void Start() => _renderer = GetComponent<Renderer>();

        private void Update()
        {
            if (Input.GetKey(KeyCode.Q))
            {
                _renderer.material = new Material(Shader.Find("Standard"))
                {
                    color = new Color(
                        UnityEngine.Random.Range(0f, 1f),
                        UnityEngine.Random.Range(0f, 1f),
                        UnityEngine.Random.Range(0f, 1f)
                    )
                };
            }
        }
    }
}