using System;
using System.Numerics;
using UnityEngine;
using static UnityEngine.Time;
using Random = System.Random;
using Vector3 = UnityEngine.Vector3;

namespace Scripts
{
    /*
     2.1 Разместите на сцене несколько кубов один над другим на некотором расстоянии друг от друга (как бы парящими в воздухе). Назначьте им компонент Rigidbody, но сделайте так, чтобы на них не действовала сила гравитации. Запустите игру, кубы не должны падать.
     2.2 Назначьте кубам вращение (через скрипт). Итог – кубы парят в воздухе и вращаются.*/

    public class RotateScript : MonoBehaviour
    {
        private void Update()
        {
            var rand = new Random();
            
            var vector = rand.Next(1, 4) switch
            {
                1 => Vector3.back,
                2 => Vector3.up,
                3 => Vector3.right,
                4 or _ => Vector3.left
            };
            
            transform.Rotate(vector * (90 * deltaTime));
        }
        
        
    }
}