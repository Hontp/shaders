using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    FSM comboSystem = new FSM();
    FSM inputSystem = new FSM();

    List<Combo> ComboList = new List<Combo>();
    Combo directional = new Combo();


    Dictionary<int, KeyCode> savedKey = new Dictionary<int, KeyCode>();
    KeyCode test;
    int id;

    public float TimeAllowToExecute = 10.5f;
    float timeLastExecute;

    void Start()
    {
        directional.AddKeys(KeyCode.DownArrow);
        directional.AddKeys(KeyCode.UpArrow);
        directional.AddKeys(KeyCode.LeftArrow);

        ComboList.Add(directional);

        comboSystem.SetState(controls);
        inputSystem.SetState(Execute);

        timeLastExecute = TimeAllowToExecute;
    }

    int GenerateId()
    {
        id++;

        return id;
    }

    float comboTimer()
    {
        if( (timeLastExecute -= Time.deltaTime) <= 0)
        {
            timeLastExecute = TimeAllowToExecute;
        }

        return timeLastExecute;
    }

    void controls()
    {

        if (Input.GetButtonDown("Up"))
        {
            savedKey.Add(GenerateId(), KeyCode.UpArrow);
        }

        if (Input.GetButtonDown("Down"))
        {
            savedKey.Add(GenerateId(), KeyCode.DownArrow);
        }

        if (Input.GetButtonDown("Left"))
        {
            savedKey.Add(GenerateId(), KeyCode.LeftArrow);
        }

        if (Input.GetButtonDown("Right"))
        {
            savedKey.Add(GenerateId(), KeyCode.RightArrow);
        }

        if ((Input.GetButtonDown("Right") & Input.GetButtonDown("Left")))
        {
            Debug.Log("Right + Left Pressed");
        }

    }

    void Execute()
    {
        float time = comboTimer();
        if (Input.GetButtonDown("Execute"))
        {

            for (int i = 0; i < directional.Count; ++i)
            {
                foreach (var element in savedKey)
                {
                    if (element.Value == directional.GetKeyList()[i])
                    {
                        if (time > 0)
                        {
                            if (directional.hasExcuted == false)
                            {
                                Debug.Log("Mega Grog Slap");
                                directional.hasExcuted = true;
                                time = 0;
                            }
                            else
                            {
                                Debug.Log("Combo Not Ready");
                            }
                        }
                    }
                }
                savedKey.Clear();

                if (time > 0)
                    directional.hasExcuted = false;
            }
        }
           
    }
	
	void Update ()
    {
        inputSystem.Update();
        comboSystem.Update();

        
	}
}
