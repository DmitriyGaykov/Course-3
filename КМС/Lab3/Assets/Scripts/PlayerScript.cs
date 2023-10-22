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
            playerCamera = GetComponentInChildren<Camera>();
            Cursor.lockState = CursorLockMode.Locked; 
            Cursor.visible = false;
        }

        private void Update()
        {
            clearList();
            if (!isDestroyed && sun is not null && Vector3.Distance(transform.position, sun.transform.position) <= 5f)
            {
                Destroy(sun);
                isDestroyed = true;
            }
            
            float horizontalInput = Input.GetAxis("Horizontal");
            float verticalInput = Input.GetAxis("Vertical");

            Vector3 moveDirection = new Vector3(horizontalInput, 0, verticalInput);
            moveDirection.Normalize();
            transform.Translate(moveDirection * (moveSpeed * Time.deltaTime));

            float mouseX = Input.GetAxis("Mouse X");
            float mouseY = Input.GetAxis("Mouse Y");

            rotation.x -= mouseY * sensitivity;
            rotation.y += mouseX * sensitivity;
            rotation.x = Mathf.Clamp(rotation.x, -90.0f, 90.0f);

            transform.rotation = Quaternion.Euler(0, rotation.y, 0);

            playerCamera.transform.localRotation = Quaternion.Euler(rotation.x, 0, 0);
            Ray ray = playerCamera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
        
            if (Physics.Raycast(ray, out hit, Mathf.Infinity))
            {
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