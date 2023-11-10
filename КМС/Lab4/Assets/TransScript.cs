using System.Collections;
using UnityEngine;
using UnityEngine.AI;

namespace Assets
{
    public class TransScript : MonoBehaviour
    {
        public float moveDistance = 4f; // Расстояние, на которое стена будет перемещаться
        public float moveDuration = 2f; // Длительность перемещения в одну сторону

        private Vector3 initialPosition; // Начальная позиция стены
        private Vector3 targetPosition; // Целевая позиция для перемещения
        private NavMeshObstacle navMeshObstacle; // Компонент NavMeshObstacle

        private void Start()
        {
            initialPosition = transform.position; // Сохраняем начальную позицию стены
            
            navMeshObstacle = GetComponent<NavMeshObstacle>();
            navMeshObstacle.enabled = true;
            navMeshObstacle.carving = true;
            navMeshObstacle.carvingMoveThreshold = 0.1f;

            // Рассчитываем целевую позицию для перемещения
            targetPosition = initialPosition + new Vector3(moveDistance, 0f, 0f);

            // Запускаем корутину для циклического перемещения стены
            StartCoroutine(MoveWall());
        }

        private IEnumerator MoveWall()
        {
            while (true)
            {
                // Перемещение вправо
                yield return MoveToPosition(targetPosition);

                // Перемещение назад
                yield return MoveToPosition(initialPosition);
            }
        }

        private IEnumerator MoveToPosition(Vector3 target)
        {
            float elapsedTime = 0f;
            Vector3 startPosition = transform.position;

            while (elapsedTime < moveDuration)
            {
                // Вычисляем прогресс перемещения
                float t = elapsedTime / moveDuration;

                // Плавно перемещаем стену к целевой позиции
                transform.position = Vector3.Lerp(startPosition, target, t);

                elapsedTime += Time.deltaTime;
                yield return null;
            }

            // Устанавливаем точную позицию после перемещения
            transform.position = target;
        }
    }
}