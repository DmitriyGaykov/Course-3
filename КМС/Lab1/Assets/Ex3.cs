using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ex3 : MonoBehaviour
{
    public GameObject cube2;

    // Update is called once per frame
    void Update() => transform.position = Vector3.MoveTowards(transform.position, cube2.transform.position, Time.deltaTime);
}
