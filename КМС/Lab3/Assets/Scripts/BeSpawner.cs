using System;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

namespace Assets.Scripts
{
    public class BeSpawner : MonoBehaviour
    {
        public GameObject bePrefab;
        public GameObject player;
        
        public int beCount = 2;

        private readonly List<GameObject> beeList = new();
        
        private void Start()
        {
            GameObject bee;
            for (int i = 0; i < beCount; i++)
            {
                bee = Instantiate(bePrefab, GetRandomPositionInRadius(), Quaternion.identity);
                bee.GetComponent<BeFlyScript>().player = player;
                beeList.Add(bee);
            }
        }
        
        private Vector3 GetRandomPositionInRadius()
        {
            // Генерируем случайные координаты в пределах заданного радиуса, но не ниже minHeight
            float randomX = Random.Range(-60, 60);
            float randomY = Random.Range(-20, 0);
            float randomZ = Random.Range(-60, 60);
 
            // Возвращаем случайную позицию в пределах радиуса
            return new Vector3(transform.position.x + randomX, randomY, transform.position.z + randomZ);
        }

        private void OnDestroy()
        {
            foreach (var bee in beeList)
            {
                Destroy(bee, .5f);
            }
        }
    }
}