using System;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.VersionControl;
using UnityEngine;
using System.Threading;
using Task = System.Threading.Tasks.Task;

namespace Assets.Scripts
{
    using UnityEngine;

    public class PlayerScript : MonoBehaviour
    {
        public GameObject sun;
        
        public float moveSpeed = 3.9f;
        public float sensitivity = 2.0f;

        private Camera playerCamera;
        private Vector3 rotation;

        public bool isDestroyed = false;

        private readonly List<(Rigidbody, DateTime)> rbList = new();
        
        private void Start()
        {
            // Получаем компонент камеры, прикрепленной к игроку
            playerCamera = GetComponentInChildren<Camera>();
            Cursor.lockState = CursorLockMode.Locked; // Блокируем курсор
            Cursor.visible = false; // Скрываем курсор
        }

        private void Update()
        {
            clearList();
            if (!isDestroyed && sun is not null && Vector3.Distance(transform.position, sun.transform.position) <= 5f)
            {
                Destroy(sun);
                isDestroyed = true;
            }
            
            // Управление движением
            float horizontalInput = Input.GetAxis("Horizontal");
            float verticalInput = Input.GetAxis("Vertical");

            Vector3 moveDirection = new Vector3(horizontalInput, 0, verticalInput);
            moveDirection.Normalize();
            transform.Translate(moveDirection * (moveSpeed * Time.deltaTime));

            // Управление камерой с помощью мыши
            float mouseX = Input.GetAxis("Mouse X");
            float mouseY = Input.GetAxis("Mouse Y");

            rotation.x -= mouseY * sensitivity;
            rotation.y += mouseX * sensitivity;
            rotation.x = Mathf.Clamp(rotation.x, -90.0f, 90.0f); // Ограничиваем угол наклона вверх и вниз

            // Поворачиваем игрока по вертикали
            transform.rotation = Quaternion.Euler(0, rotation.y, 0);

            // Поворачиваем камеру по горизонтали
            playerCamera.transform.localRotation = Quaternion.Euler(rotation.x, 0, 0);
            
            // Нарисуй лучь, который будет идити от центра героя в направлении курсора
           
            Ray ray = playerCamera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
        
            if (Physics.Raycast(ray, out hit, Mathf.Infinity))
            {
                // Если луч пересекает объект, вы можете выполнить дополнительные действия здесь

                if (hit.collider.gameObject.name.StartsWith("Bee"))
                {
                    hit.rigidbody.useGravity = true;
                    this.rbList.Add((hit.rigidbody, DateTime.Now));
                }
            }
        }

        void clearList()
        {
            foreach (var el in this.rbList)
            {
                if ((DateTime.Now - el.Item2) > TimeSpan.FromSeconds(2))
                {
                    el.Item1.useGravity = false;
                    this.rbList.Remove(el);
                }
            }
        }
    }

}