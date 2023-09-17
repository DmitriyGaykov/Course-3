using UnityEngine;

namespace Assets
{
    public class Ex5 : MonoBehaviour
    {
        private Rigidbody rb = null;
        private readonly float speed = .2f;
        private void Start() => rb = GetComponent<Rigidbody>();

        // Сделан пинок для шара, чтобы когда я нажал на W, шарик полетел вперед, S - назад, A - влево, D - вправо
        private void Update()
        {
            float 
                x = Input.GetAxis("Horizontal"),
                z = Input.GetAxis("Vertical");
            
            rb?.AddForce(new Vector3(x, 0, z) * speed, ForceMode.Impulse);
        }
        
    }
}