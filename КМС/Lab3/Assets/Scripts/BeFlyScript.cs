using System;
using UnityEngine;
using Random = UnityEngine.Random;

namespace Assets.Scripts
{
    public class BeFlyScript : MonoBehaviour
    {
        private static DateTime lastReduce = DateTime.Now;
        public GameObject player;
        
        public float moveSpeed = 9.0f;
        public float rotationSpeed = 5.0f; 
        public float radius = 20.0f;
        public float minHeight = 2.0f; 
        private Vector3 targetPosition;

        private void Start()
        {
            targetPosition = GetRandomPositionInRadius();
        }

        private void Update()
        {
            if (Vector3.Distance(transform.position, player.transform.position) <= 5f)
            {
                if((DateTime.Now - lastReduce) > TimeSpan.FromSeconds(1))
                {
                    lastReduce = DateTime.Now;
                    player.GetComponent<PlayerScript>().moveSpeed /= 1.2f;
                }
            } 
            if (Vector3.Distance(transform.position, player.transform.position) <= 40f)
            {
                targetPosition = player.transform.position;
                moveSpeed = Random.Range(5f, 15f);
            }
            else if (Vector3.Distance(transform.position, targetPosition) < 0.1f)
            { 
                targetPosition = GetRandomPositionInRadius(); 
                moveSpeed = 3.0f;
            } 
            
            transform.position = Vector3.MoveTowards(transform.position, targetPosition, moveSpeed * Time.deltaTime);

            Quaternion targetRotation = Quaternion.LookRotation(targetPosition - transform.position);
            targetRotation *= Quaternion.Euler(0.0f, -90.0f, 0.0f);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, rotationSpeed * Time.deltaTime);
        }

        private Vector3 GetRandomPositionInRadius()
        {
            float randomX = Random.Range(-radius, radius);
            float randomY = Random.Range(minHeight, 10f);
            float randomZ = Random.Range(-radius, radius);

            return new Vector3(transform.position.x + randomX, randomY, transform.position.z + randomZ);
        }
    }
}