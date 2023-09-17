using System;
using UnityEngine;

namespace Assets
{
    public class Ex7 : MonoBehaviour
    {
        public GameObject _followingObject;
        
        private Rigidbody rb = null;
        private readonly float speed = .07f;
        
        private void Start() => rb = GetComponent<Rigidbody>();
        
        private void Update()
        {
            if (_followingObject is not null)
            {
                // движение в сторону _followingObject
                var direction = _followingObject.transform.position - transform.position;
                rb?.AddForce(direction * speed, ForceMode.Impulse);
            }
        }
    }
}