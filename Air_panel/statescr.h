#ifndef STATESCR_H
#define STATESCR_H


class StateScr
{
public:
    StateScr(const StateScr&) = delete;                     // Copy Constructor (delete)
    StateScr &operator=(const StateScr&) = delete;          // Assignment operator (delete)
    ~StateScr();                                            // Destructor
    static StateScr& get_instance();
    void set_state(const int&);
    int get_state();

private:
    int m_state;
    StateScr();
};

#endif // STATESCR_H
