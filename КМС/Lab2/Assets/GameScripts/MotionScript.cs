using UnityEngine;

public class MotionScript : MonoBehaviour
{
    public float moveDistanceLeft = 10f;  // Расстояние влево.
    public float moveDistanceRight = 20f; // Расстояние вправо.
    public float moveSpeed = 5f;          // Скорость движения.

    private Vector3 initialPosition;
    private bool movingRight = true;

    private void Start()
    {
        initialPosition = transform.position;
    }

    private void Update()
    {
        if (movingRight)
        {
            // Двигаем объект вправо.
            transform.Translate(Vector3.right * (moveSpeed * Time.deltaTime));
            
            // Проверяем, достиг ли объект максимального расстояния вправо.
            if (transform.position.x >= initialPosition.x + moveDistanceRight)
            {
                movingRight = false;
            }
        }
        else
        {
            // Двигаем объект влево.
            transform.Translate(Vector3.left * (moveSpeed * Time.deltaTime));
            
            // Проверяем, достиг ли объект максимального расстояния влево.
            if (transform.position.x <= initialPosition.x - moveDistanceLeft)
            {
                movingRight = true;
            }
        }
    }
}