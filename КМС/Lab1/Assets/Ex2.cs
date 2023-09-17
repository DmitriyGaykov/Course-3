using System.Collections;
using UnityEngine;

namespace Assets
{
    public class Ex2 : MonoBehaviour
    {
        private Component component;
        private readonly float speed = 0.05f;

        // Use this for initialization
        void Start() => component = gameObject.GetComponent<Transform>();

        // Update is called once per frame
        void Update()
        {
            var pos = component.transform.position;

            float 
                posX = pos.x,
                posY = pos.y,
                posZ = pos.z;

            component.transform.position = new(posX + speed, posY, posZ);
        }
    }
}