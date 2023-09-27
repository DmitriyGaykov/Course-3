using UnityEngine;

namespace Assets
{
    public class Ex5 : MonoBehaviour
    {
        private Rigidbody rb = null;
        private readonly float speed = .2f;
        private void Start() => rb = GetComponent<Rigidbody>();

        private void Update()
        {
            float 
                x = Input.GetAxis("Horizontal"),
                z = Input.GetAxis("Vertical");
            
            rb?.AddForce(new Vector3(x, 0, z) * speed, ForceMode.Impulse);
        }
        
    }
}