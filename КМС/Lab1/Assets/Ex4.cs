using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ex4 : MonoBehaviour
{
    private readonly float jumpForce = .2f; // Сила прыжка
    private Rigidbody rb;

    void Start() => rb = GetComponent<Rigidbody>();

    void Update()
    {
        if (Input.GetKey(KeyCode.Space)) 
        {
            Jump();
        }
    }

    void Jump() => rb?.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
}
