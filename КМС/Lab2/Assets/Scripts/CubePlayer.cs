using System;
using UnityEngine;

namespace Scripts
{
    public class CubePlayer : MonoBehaviour
    {
        private void OnCollisionEnter(Collision other)
        {
            string objectName = other.gameObject.name;
            Debug.Log($"Hit the {objectName}");
        }
    }
}