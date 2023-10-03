using System;
using UnityEngine;

namespace Assets.GameScripts
{
    public class PushAway : MonoBehaviour
    {
        private Rigidbody _rb;
        
        private void Start() => _rb = GetComponent<Rigidbody>();
        
        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.name.Contains("Ammo"))
            { 
                _rb.AddExplosionForce(100_000f, transform.position, 1_000f);
            }
        }
    }
}