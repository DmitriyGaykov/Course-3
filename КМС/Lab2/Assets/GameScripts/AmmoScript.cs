using System;
using UnityEngine;

namespace Assets.GameScripts
{
    public class AmmoScript : MonoBehaviour
    {
        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.name is "Plane")
                return;
            
            other.gameObject.GetComponent<Rigidbody>().AddForce(Vector3.up * 5_000);
        }
    }
}