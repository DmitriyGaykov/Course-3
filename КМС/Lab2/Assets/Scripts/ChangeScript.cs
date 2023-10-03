using System;
using System.Collections.Generic;
using UnityEngine;

namespace Scripts
{
    public class ChangeScript : MonoBehaviour
    {
        /*
         * 5.2. На поверхности разместите триггер в виде плоскости отличного от поверхности цвета.
         * 5.3. Напишите скрипт в функции FixedUpdate, который при входе сферы в область триггера будет увеличивать размер сферы (можно менять другой параметр на свое усмотрение), а при повторном входе в зону триггера сфера уменьшится. 
         */

        private readonly Dictionary<string, DateTime> _lastVisit = new();
        private readonly Dictionary<string, bool> _wasTriggered = new();

        private void OnTriggerEnter(Collider other)
        {
            var gameObject = other.gameObject;
            if (_lastVisit.TryGetValue(gameObject.name, out var dateOfLast))
            {
                if (DateTime.Now - dateOfLast > TimeSpan.FromMilliseconds(1_000))
                {
                    if (_wasTriggered.TryGetValue(gameObject.name, out var isTrigger))
                    {
                        if (isTrigger)
                        {
                            other.gameObject.transform.localScale -= new Vector3(0.5f, 0.5f, 0.5f);
                            _wasTriggered[gameObject.name] = false;
                        }
                        else
                        {
                            other.gameObject.transform.localScale += new Vector3(0.5f, 0.5f, 0.5f);
                            _wasTriggered[gameObject.name] = true;
                        }
                    }
                }
            }
            else
            {
                _lastVisit[gameObject.name] = new DateTime();
                _wasTriggered[gameObject.name] = false;
                OnTriggerEnter(other);
                return;
            }
            _lastVisit[gameObject.name] = DateTime.Now;
        }
    }
}