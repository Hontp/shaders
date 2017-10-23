using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Combo
{
    List<KeyCode> keyList = new List<KeyCode>();
    public bool hasExcuted = false;

    public int Count
    {
        get
        {
            return keyList.Count;
        }
           
    }

    public void AddKeys(KeyCode key)
    {
        keyList.Add(key);
    }

    public List<KeyCode> GetKeyList()
    {
        return keyList;
    }
}
