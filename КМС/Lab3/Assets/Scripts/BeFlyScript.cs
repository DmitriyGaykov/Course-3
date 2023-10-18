using System;
using UnityEngine;
using Random = UnityEngine.Random;

namespace Assets.Scripts
{
    public class BeFlyScript : MonoBehaviour
    {
        private static DateTime lastReduce = DateTime.Now;
        public GameObject player;
        
        public float moveSpeed = 9.0f; // Скорость движения пчелы
        public float rotationSpeed = 5.0f; // Скорость поворота пчелы
        public float radius = 20.0f; // Радиус, в котором пчела может летать
        public float minHeight = 2.0f; // Минимальная высота, на которой пчела может находиться
        private Vector3 targetPosition;

        private void Start()
        {
            // Инициализируем начальную позицию и целевую позицию пчелы
            targetPosition = GetRandomPositionInRadius();
        }

        private void Update()
        {
            // Если пчела достигла целевой позиции, задаем новую случайную позицию в заданном радиусе

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
            

            // Пчела двигается к целевой позиции
            transform.position = Vector3.MoveTowards(transform.position, targetPosition, moveSpeed * Time.deltaTime);

            // Поворачиваем пчелу в сторону целевой позиции
            Quaternion targetRotation = Quaternion.LookRotation(targetPosition - transform.position);
            // Поваричиваем ее на 90 градусов по оси Y, чтобы она смотрела вперед
            targetRotation *= Quaternion.Euler(0.0f, -90.0f, 0.0f);
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, rotationSpeed * Time.deltaTime);
        }

        private Vector3 GetRandomPositionInRadius()
        {
            // Генерируем случайные координаты в пределах заданного радиуса, но не ниже minHeight
            float randomX = Random.Range(-radius, radius);
            float randomY = Random.Range(minHeight, 10f);
            float randomZ = Random.Range(-radius, radius);

            // Возвращаем случайную позицию в пределах радиуса
            return new Vector3(transform.position.x + randomX, randomY, transform.position.z + randomZ);
        }
    }
}