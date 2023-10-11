using System;
using UnityEngine;
using Random = System.Random;

namespace Scripts
{
    public class ForceCollition : MonoBehaviour
    {
        /*
         * 2.3. Назначьте верхнему кубу скрипт, который при соприкосновении с объектом придаст объекту силу AddForce в горизонтальном направлении.
         * 2.4. Включите у верхнего куба гравитацию, запустите игру. Кубы должны вылетать из-под верхнего в сторону.
         */
        
        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.name.Equals("Floor"))
                return;
            
            var rand = new Random();
            
            var vector = rand.Next(1, 4) switch
            {
                1 => Vector3.back,
                2 => Vector3.up,
                3 => Vector3.right,
                4 or _ => Vector3.left
            };
            
            other.gameObject.GetComponent<Rigidbody>().AddForce(vector * 1000);
        }
    }
}