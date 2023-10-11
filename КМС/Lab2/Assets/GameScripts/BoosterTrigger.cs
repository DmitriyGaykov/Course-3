using UnityEngine;

namespace Assets.GameScripts
{
    public class BoosterTrigger : MonoBehaviour
    {
        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name.Contains("Ammo") && !other.gameObject.name.Contains("Booster"))
            {
                Transform ammoTransform = other.transform;

                ammoTransform.localScale *= 16f;

                Rigidbody ammoRigidbody = other.GetComponent<Rigidbody>();
                Renderer renderer = other.GetComponent<Renderer>();

                if (ammoRigidbody is not null && renderer is not null)
                {
                    ammoRigidbody.velocity *= 1.2f;
                    ammoRigidbody.mass = 50;
                    renderer.material.color = Color.red;
                    
                    other.gameObject.name += "Booster";
                }
            }
        }
    }
}