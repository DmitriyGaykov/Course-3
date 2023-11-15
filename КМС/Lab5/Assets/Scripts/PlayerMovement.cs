using System;
using UnityEngine;

namespace Assets.Scripts
{
  public class PlayerMovement : MonoBehaviour
  {
    public CharacterController controller;
    public float speed = 10f;
    public float gravity = -9.81f;
    public float jumpHeight = 30f;
    
    Vector3 velocity;
    
    void Update()
    {
      float x = Input.GetAxis("Horizontal");
      float z = Input.GetAxis("Vertical");
      
      if(Input.GetButtonDown("Jump"))
      {
        velocity.y = Mathf.Sqrt(jumpHeight * -2f * gravity);
        return;
      }

      Vector3 move = transform.right * x + transform.forward * z;
      controller.Move(move * (speed * Time.deltaTime));
      
      velocity.y += gravity * Time.deltaTime;
      controller.Move(velocity * Time.deltaTime);
    }
  }
}