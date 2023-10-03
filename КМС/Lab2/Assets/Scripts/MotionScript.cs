using UnityEngine;

namespace Scripts
{
    public class MotionScript : MonoBehaviour
    {
        // Движение клавишами для сферы с rb
        
        private Rigidbody rb;
        public float speed = 400f;
        private float _horizontal;
        private float _vertical;
        
        private void Start()
        {
            rb = GetComponent<Rigidbody>();
        }
        
        private void Update()
        {
            _horizontal = Input.GetAxis("Horizontal");
            _vertical = Input.GetAxis("Vertical");
        }
        
        private void FixedUpdate()
        {
            rb.AddForce(new Vector3(_horizontal, 0, _vertical) * speed);
        }
        
        
    }
}