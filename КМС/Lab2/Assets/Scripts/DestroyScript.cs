using UnityEngine;

namespace Scripts
{
    public class DestroyScript : MonoBehaviour
    {
        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.name is not ("Floor" or "LeftWall" or "RightWall"))
            {
                Destroy(other.gameObject);
            }
        }
    }
}