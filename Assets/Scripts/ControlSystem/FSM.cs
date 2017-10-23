public class FSM
{
    public delegate void State();

    State activeState;

    public void SetState( State func)
    {
        activeState = func;
    }

    public void Update()
    {
        if (activeState != null)
        {
            activeState();
        }
    }
   
}
