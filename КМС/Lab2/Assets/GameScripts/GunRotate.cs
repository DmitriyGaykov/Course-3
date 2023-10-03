using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

public class GunRotate : MonoBehaviour
{
    // Подымать пушку вверх и опускать ее на W и S. Крутить вправо влево на A и D. Ограничить угол поворота пушки.
    // Поворот должет идти относительно предыдущих координат и поворота

    public GameObject ammo;
    
    private float _rotationSpeed = 10f;
    private float _rotationAngle = 0f;
    private float _rotationLimit = 85f;
    
    void Update()
    {
        Fire();
        MoveGun();
    }

    void Fire()
    {
        if (Input.GetMouseButtonDown(0))
        {
            var ammoInstance = Instantiate(ammo, transform.position, Quaternion.identity);
        
            // Получаем направление от верхней части пушки (transform.up), учитывая угол наклона.
            Vector3 fireDirection = transform.rotation * Vector3.up;
        
            // Добавляем силу в направлении от верхней части пушки.
            ammoInstance.GetComponent<Rigidbody>().AddForce(fireDirection * 15_000f);
            Destroy(ammoInstance, 1.5f);
        }
    }

    
    void MoveGun()
    {
        if (Input.GetKey(KeyCode.S))
        {
            if (_rotationAngle < _rotationLimit)
            {
                transform.Rotate(Vector3.right, _rotationSpeed * Time.deltaTime);
                _rotationAngle += _rotationSpeed * Time.deltaTime;
            }
        }
        else if (Input.GetKey(KeyCode.W))
        {
            if (_rotationAngle > -_rotationLimit)
            {
                transform.Rotate(Vector3.left, _rotationSpeed * Time.deltaTime);
                _rotationAngle -= _rotationSpeed * Time.deltaTime;
            }
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
