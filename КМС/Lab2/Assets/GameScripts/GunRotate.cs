using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

public class GunRotate : MonoBehaviour
{
    // Подымать пушку вверх и опускать ее на W и S. Крутить вправо влево на A и D. Ограничить угол поворота пушки.
    // Поворот должет идти относительно предыдущих координат и поворота

    public GameObject ammo;
    public GameObject aim;
    
    private float _rotationSpeed = 11f;
    
    void Update()
    {
        Fire();
        MoveGun();
    }

    void Fire()
    {
        if (Input.GetMouseButtonDown(0))
        {
            // Получаем текущую позицию пушки.
            Vector3 shootPosition = transform.position;

            // Получаем направление от текущей позиции пушки к позиции aim.
            Vector3 fireDirection = aim.transform.position - shootPosition;

            // Создаем пулю в текущей позиции пушки.
            var ammoInstance = Instantiate(ammo, shootPosition, Quaternion.identity);

            // Устанавливаем силу пули.
            float bulletSpeed = 15_000f;
            ammoInstance.GetComponent<Rigidbody>().AddForce(fireDirection.normalized * bulletSpeed);

            // Уничтожаем пулю через 2.5 секунды.
            Destroy(ammoInstance, 2.5f);
        }
    }


    
    void MoveGun()
    {
        if (Input.GetKey(KeyCode.S))
        {
            transform.Rotate(Vector3.right, _rotationSpeed * Time.deltaTime);
        }
        else if (Input.GetKey(KeyCode.W))
        {
            transform.Rotate(Vector3.left, _rotationSpeed * Time.deltaTime);
        }
        else if (Input.GetKey(KeyCode.D))
        {
            transform.Rotate(Vector3.back, _rotationSpeed * Time.deltaTime);
        }
        else if (Input.GetKey(KeyCode.A))
        {
            transform.Rotate(Vector3.forward, _rotationSpeed * Time.deltaTime);
        }
    }
}
